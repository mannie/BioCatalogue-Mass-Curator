package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.DocURLAnnotatedEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface ServiceVariant extends AnnotatableEntity, TimeStampedEntity, DescribedEntity, SubmittedEntity, DocURLAnnotatedEntity {

}
