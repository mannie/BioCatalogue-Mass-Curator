package models.interfaces.resources.helpers;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.DocURLAnnotatedEntity;
import models.interfaces.abstracts.PartiallyLoadableEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface ServiceVariant extends AnnotatableEntity, DescribedEntity, DocURLAnnotatedEntity, SubmittedEntity, TimeStampedEntity, PartiallyLoadableEntity {

}
